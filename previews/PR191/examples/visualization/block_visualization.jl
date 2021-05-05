using Images
using PaddedViews, OffsetArrays
using TestImages
using ImageBinarization

img = imresize(testimage("lighthouse"), ratio=0.5)
img₀₁ = binarize(img, AdaptiveThreshold())

mosaic(img, img₀₁; nrow=1)

using TiledIteration
tile_indices = TileIterator(axes(img), (32, 32))[:]
tiles = [img[R...] for R in tile_indices]
# visualize the tiles at fps rate 5, i.e., 5 frames per second.
Images.gif(tiles; fps=5)

function create_frames(img, background, tile_indices; rf=0.8, rb=1-rf)
    map(tile_indices) do R
        # add back axes information to given blcok
        block = OffsetArray(img[R...], OffsetArrays.Origin(first.(R)))
        canvas, block = paddedviews(zero(eltype(background)), background, block)
        frame = clamp01!(@. rb*canvas .+ rf*block)
    end
end

frames = create_frames(img, img, tile_indices)
Images.gif(frames; fps=5)

frames = create_frames(img₀₁, img, tile_indices; rb=0.4)
Images.gif(frames; fps=5)

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

