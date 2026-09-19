return {
	"scalameta/nvim-metals",
	ft = { "scala", "sbt", "java" },
	opts = function()
		local metals_config = require("metals").bare_config()

		local blink_capabilities = require("blink.cmp").get_lsp_capabilities()

		metals_config.capabilities = vim.tbl_deep_extend("force", metals_config.capabilities or {}, blink_capabilities)

		metals_config.settings = {
			serverVersion = "2.0.0-M2",
			serverProperties = { "-Xmx4g" },
		}

		metals_config.settings = {
			serverVersion = "2.0.0-M2",
			serverProperties = {
				"-Djol.magicFieldOffset=true",
				"-Djol.tryWithSudo=true",
				"-Djdk.attach.allowAttachSelf",
				"--add-opens=java.base/java.nio=ALL-UNNAMED",
				"--add-exports=jdk.compiler/com.sun.tools.javac.api=ALL-UNNAMED",
				"--add-exports=jdk.compiler/com.sun.tools.javac.code=ALL-UNNAMED",
				"--add-exports=jdk.compiler/com.sun.tools.javac.comp=ALL-UNNAMED",
				"--add-exports=jdk.compiler/com.sun.tools.javac.file=ALL-UNNAMED",
				"--add-exports=jdk.compiler/com.sun.tools.javac.jvm=ALL-UNNAMED",
				"--add-exports=jdk.compiler/com.sun.tools.javac.main=ALL-UNNAMED",
				"--add-exports=jdk.compiler/com.sun.tools.javac.model=ALL-UNNAMED",
				"--add-exports=jdk.compiler/com.sun.tools.javac.parser=ALL-UNNAMED",
				"--add-exports=jdk.compiler/com.sun.tools.javac.processing=ALL-UNNAMED",
				"--add-exports=jdk.compiler/com.sun.tools.javac.resources=ALL-UNNAMED",
				"--add-exports=jdk.compiler/com.sun.tools.javac.tree=ALL-UNNAMED",
				"--add-exports=jdk.compiler/com.sun.tools.javac.util=ALL-UNNAMED",
				"--add-opens=java.base/sun.nio.ch=ALL-UNNAMED",
				"--add-opens=jdk.compiler/com.sun.tools.javac.code=ALL-UNNAMED",
				"--add-opens=jdk.compiler/com.sun.tools.javac.comp=ALL-UNNAMED",
				"--add-opens=jdk.compiler/com.sun.tools.javac.file=ALL-UNNAMED",
				"--add-opens=jdk.compiler/com.sun.tools.javac.parser=ALL-UNNAMED",
				"-XX:+DisplayVMOutputToStderr",
				"-Xlog:disable",
				"-Xlog:all=warning,gc=warning:stderr",
			},
		}

		metals_config.on_attach = function(client, bufnr)
			-- your on_attach function
		end

		return metals_config
	end,
	config = function(self, metals_config)
		local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
		vim.api.nvim_create_autocmd("FileType", {
			pattern = self.ft,
			callback = function()
				require("metals").initialize_or_attach(metals_config)
			end,
			group = nvim_metals_group,
		})
	end,
}
