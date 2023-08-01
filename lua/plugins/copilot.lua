return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        build = ":Copilot auth",
        event = "InsertEnter",
        module = "Copilot",
        opts = {
            suggestion = { enable = false },
            panel = { enable = false },
        },
    },
}
