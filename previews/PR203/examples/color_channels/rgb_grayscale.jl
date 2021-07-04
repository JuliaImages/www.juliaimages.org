using ImageCore, TestImages

rgb_image = testimage("lighthouse")

gray_image = Gray.(rgb_image)
mosaicview(rgb_image, gray_image; nrow = 1)

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

