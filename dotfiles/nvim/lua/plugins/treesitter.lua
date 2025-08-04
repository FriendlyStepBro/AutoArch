return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = { "c", "lua", "c_sharp", "bash", "hyprlang", "java", "javascript", "json", "kotlin", "llvm", "go", "gosum", "gomod", "gowork", "goctl", "gpg", "luadoc", "make", "markdown", "matlab", "nasm", "nginx", "passwd", "rust", "razor", "regex", "css", "csv", "cuda", "cpp", "cmake", "awk", "arduino", "asm", "dockerfile", "desktop", "git_config", "git_rebase", "gitattributes", "gitcommit", "gitignore", "glsl", "html", "http", "ini", "xml", "powershell", "python", "sql", "ssh_config", "tmux", "todotxt", "toml", "typescript", "udev", "vim", "vimdoc", "wgsl", "yaml", "zig"},
            auto_install = true,
            highlight = {
                enable = true,
                disable = {},
                additional_vim_regex_highlighting = true,
            },
            indent = { enable = true },
            playground = {
                enable = true,
                updatetime = 25,
                persist_queries = false,
            },
        })
    end,
}
