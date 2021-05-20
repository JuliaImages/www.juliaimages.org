using Images

img = [
    RGB(0.0, 0.0, 0.0) RGB(1.0, 0.0, 0.0) RGB(0.0, 1.0, 0.0) RGB(0.0, 0.0, 1.0) RGB(1.0, 1.0, 1.0)
    RGB(1.0, 0.0, 0.0) RGB(0.0, 1.0, 0.0) RGB(0.0, 0.0, 1.0) RGB(1.0, 1.0, 1.0) RGB(0.0, 0.0, 0.0)
    RGB(0.0, 1.0, 0.0) RGB(0.0, 0.0, 1.0) RGB(1.0, 1.0, 1.0) RGB(0.0, 0.0, 0.0) RGB(1.0, 0.0, 0.0)
    RGB(0.0, 0.0, 1.0) RGB(1.0, 1.0, 1.0) RGB(0.0, 0.0, 0.0) RGB(1.0, 0.0, 0.0) RGB(0.0, 1.0, 0.0)
    RGB(1.0, 1.0, 1.0) RGB(0.0, 0.0, 0.0) RGB(1.0, 0.0, 0.0) RGB(0.0, 1.0, 0.0) RGB(0.0, 0.0, 1.0)]

indices = [1 2 3 4 5; 2 3 4 5 1; 3 4 5 1 2; 4 5 1 2 3; 5 1 2 3 4] # `i` records the pixel value `palatte[i]`
palatte = [RGB(0.0, 0.0, 0.0), RGB(1.0, 0.0, 0.0), RGB(0.0, 1.0, 0.0), RGB(0.0, 0.0, 1.0), RGB(1.0, 1.0, 1.0)]

palatte[indices] == img

palatte[[1, 2]] == [palatte[1], palatte[2]]
palatte[[1 2; 2 1]] == [palatte[1] palatte[2]; palatte[2] palatte[1]]

using IndirectArrays

indexed_img = IndirectArray(indices, palatte)
img == indexed_img

indexed_img.index === indices, indexed_img.values === palatte

imresize(indexed_img; ratio=2) # no longer an IndirectArray

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

