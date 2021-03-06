using Documenter, PAPI

makedocs(;
    modules = [PAPI],
    sitename = "PAPI.jl",
    authors = "Tom Haber <tom.haber@uhasselt.be>",
    pages = [
        "Home" => "index.md",
        "Events" => "events.md",
        "Event Sets" => "eventsets.md",
        "Counting" => "counters.md",
        "Library" => [
            "Public" => "public.md",
            "Internals" => "internals.md",
        ]
    ]
)

deploydocs(;
    repo="github.com/tomhaber/PAPI.jl.git"
)
