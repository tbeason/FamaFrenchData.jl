using Documenter, FamaFrenchData


makedocs(
    sitename = "FamaFrenchData.jl",
    modules=[FamaFrenchData],
    pages=["Home"=>"index.md"],
    format = Documenter.HTML(prettyurls = get(ENV, "CI", nothing) == "true")
)


deploydocs(
    repo = "github.com/tbeason/FamaFrenchData.jl.git",
    push_preview=true
)