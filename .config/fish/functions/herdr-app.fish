# herdr-app.exe is a Windows GUI program: run from WSL, it only prints when its output
# goes into a pipe, so send it through cat. Exit status and `herdr-app` (opens the window)
# still work as usual.
function herdr-app --wraps herdr-app --description "herdr-app.exe from WSL: pipe output so it shows"
    command herdr-app $argv | cat
    return $pipestatus[1]
end
