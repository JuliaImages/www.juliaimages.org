using ImageContrastAdjustment
using Images
using Plots
using TestImages

img_source = testimage("chelsea");
img_reference = testimage("coffee");

img_transformed = adjust_histogram(img_source, Matching(targetimg = img_reference))
mosaicview(img_source, img_reference, img_transformed; nrow = 1)

hist_final = [histogram(vec(c.(img)))
    for c in (red, green, blue)
    for img in [img_source, img_reference, img_transformed]
]

plot(
    hist_final...,
    layout = (3, 3),
    size = (800, 800),
    legend = false,
    title = ["Source" "Reference" "Histograms Matched"],
    reuse = false,
)

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

