# ---
# title: Block-by-Block Visualization
# description: This demo shows you how to create a block-by-block image visualization.
# cover: assets/block_visualization.gif
# author: Johnny Chen
# date: 2021-05-05
# ---

using Images
using PaddedViews, OffsetArrays
using TestImages
using ImageBinarization

# !!! note
#     It is recommended to read the demo [Layer Compositing](@ref Layer-Compositing) first to get an idea
#     of how [OffsetArrays.jl](https://github.com/JuliaArrays/OffsetArrays.jl) and
#     [PaddedViews.jl](https://github.com/JuliaArrays/PaddedViews.jl) can be used to simplify the
#     canvas/axes organization.

img = imresize(testimage("lighthouse"), ratio=0.5)
img₀₁ = binarize(img, AdaptiveThreshold())

# As you may have seen in other demos, the simplest way to compare multiple images is to use `mosaic`:

mosaic(img, img₀₁; nrow=1)

# In this demo, we will use `Images.gif` to create something different by adding a "time" axis. As
# an example, we use `TiledIteration` to move our focus on a block/patch/tile level.

using TiledIteration
tile_indices = TileIterator(axes(img), (32, 32))[:]
tiles = [img[R...] for R in tile_indices]
## visualize the tiles at fps rate 5, i.e., 5 frames per second.
Images.gif(tiles; fps=5)

# This is not very meaningful as it simply stacks all tiles together, so next we'll add
# back the axes information for each block. We also use the original image as the
# background.

function create_frames(img, background, tile_indices; rf=0.8, rb=1-rf)
    map(tile_indices) do R
        ## add back axes information to given blcok
        block = OffsetArray(img[R...], OffsetArrays.Origin(first.(R)))
        canvas, block = paddedviews(zero(eltype(background)), background, block)
        frame = clamp01!(@. rb*canvas .+ rf*block)
    end
end

frames = create_frames(img, img, tile_indices)
Images.gif(frames; fps=5)

# Now, instead of using `mosaic`, we use this to compare our images.

frames = create_frames(img₀₁, img, tile_indices; rb=0.4)
Images.gif(frames; fps=5)

# This may not be the best way to visually compare these two images, but you get the
# idea of how to add back axes information to each block, and visualize it as an animated
# GIF.

# make cover image #src
tile_indices = TileIterator(axes(img), (48, 48))[:] #src
frames = create_frames(img₀₁, img, tile_indices; rb=0.4) #src
save("assets/block_visualization.gif", Images.gif(frames); fps=2) #src
