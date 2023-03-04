using Documenter
using DataNetworkModels



makedocs(
    sitename = "DataNetworkModels",
    format = Documenter.HTML(),
    modules = [DataNetworkModels]
)

# Documenter can also automatically deploy documentation to gh-pages.
# See "Hosting Documentation" and deploydocs() in the Documenter manual
# for more information.
deploydocs(
    repo = "github.com:LexaLutyi/DataNetworkModels.jl.git",
    devbranch = "main"
)
