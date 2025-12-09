local venv_status_ok, venv = pcall(require, "venv-selector")
if not venv_status_ok then
  return
end

venv.setup {}
