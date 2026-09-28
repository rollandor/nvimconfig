local M = {}
local busy = false

local function failure(result, root)
  local output = (result.stderr or "") .. "\n" .. (result.stdout or "")
  local lines = vim.split(output, "\n", { trimempty = true })
  for i, line in ipairs(lines) do
    if line:match "^.+:%d+:" and not vim.startswith(line, "/") then
      lines[i] = root .. "/" .. line
    end
  end
  vim.fn.setqflist({}, " ", {
    title = "Go build: " .. root,
    lines = lines,
    efm = "%f:%l:%c: %m,%f:%l: %m,%-G#%.%#,%-G%.%#",
  })
  vim.cmd "copen"
  vim.notify(output, vim.log.levels.ERROR)
end

function M.build()
  if busy then
    return vim.notify "Go build is already running"
  end
  local root = vim.fs.root(0, "go.mod") or vim.fs.root(vim.fn.getcwd(), "go.mod")
  if not root then
    return vim.notify("Open a file inside a Go module (go.mod)", vim.log.levels.WARN)
  end
  if vim.fn.executable "go" == 0 then
    return vim.notify("go is not on PATH", vim.log.levels.ERROR)
  end
  vim.cmd "wall"
  busy = true
  vim.notify "Finding Go main packages…"
  vim.system(
    { "go", "list", "-f", '{{if eq .Name "main"}}{{.ImportPath}}{{end}}', "./..." },
    { cwd = root, text = true },
    vim.schedule_wrap(function(result)
      if result.code ~= 0 then
        busy = false
        return failure(result, root)
      end
      local packages = vim.split(result.stdout or "", "\n", { trimempty = true })
      local function compile(package)
        if not package then
          busy = false
          return
        end
        local name = package:match "([^/]+)$"
        local output = root .. "/bin/" .. name
        vim.fn.mkdir(root .. "/bin", "p")
        vim.notify("Building " .. package)
        vim.system(
          { "go", "build", "-o", output, package },
          { cwd = root, text = true },
          vim.schedule_wrap(function(build)
            busy = false
            if build.code ~= 0 then
              return failure(build, root)
            end
            vim.fn.setqflist({}, "r")
            vim.notify("Built: " .. output)
          end)
        )
      end
      if #packages == 0 then
        busy = false
        vim.notify("No main packages found in " .. root, vim.log.levels.WARN)
      elseif #packages == 1 then
        compile(packages[1])
      else
        vim.ui.select(packages, { prompt = "Build Go package:" }, compile)
      end
    end)
  )
end

return M
