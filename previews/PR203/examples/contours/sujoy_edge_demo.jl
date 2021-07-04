using Images
using Statistics
using TestImages
using ImageBinarization

"""
    edges = sujoy(img; four_connectivity=true)

Compute edges of an image using the Sujoy algorithm.

# Parameters

* `img` (Required): any gray image
* `four_connectivity=true`: if true, kernel is based on 4-neighborhood, else, kernel is based on
   8-neighborhood,

# Returns

* `edges` : gray image
"""
function sujoy(img; four_connectivity=true)
    img_channel = Gray.(img)

    min_val = minimum(img_channel)
    img_channel = img_channel .- min_val
    max_val = maximum(img_channel)

    if max_val == 0
        return img
    end

    img_channel = img_channel./max_val

    if four_connectivity
        krnl_h = centered(Gray{Float32}[0 -1 -1 -1 0; 0 -1 -1 -1 0; 0 0 0 0 0; 0 1 1 1 0; 0 1 1 1 0]./12)
        krnl_v = centered(Gray{Float32}[0 0 0 0 0; -1 -1 0 1 1;-1 -1 0 1 1;-1 -1 0 1 1;0 0 0 0 0 ]./12)
    else
        krnl_h = centered(Gray{Float32}[0 0 -1 0 0; 0 -1 -1 -1 0; 0 0 0 0 0; 0 1 1 1 0; 0 0 1 0 0]./8)
        krnl_v = centered(Gray{Float32}[0 0 0 0 0;  0 -1 0 1 0; -1 -1 0 1 1;0 -1 0 1 0; 0 0 0 0 0 ]./8)
    end

    grad_h = imfilter(img_channel, krnl_h')
    grad_v = imfilter(img_channel, krnl_v')

    grad = (grad_h.^2) .+ (grad_v.^2)

    return grad
end

img = testimage("cameraman")
img_edge = sujoy(img, four_connectivity=true)
img_edge₀₁ = binarize(img_edge, Otsu()) # or use other binarization methods provided in ImageBinarization

mosaicview(img, img_edge, img_edge₀₁; nrow = 1)

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

