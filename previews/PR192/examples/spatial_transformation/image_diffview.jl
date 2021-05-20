using Images
using TestImages

img = float.(testimage("cameraman"))
# rotate img by 4 degrees and keep axes unchanged
img_r = imrotate(img, -pi/45, axes(img))

mosaicview(img, img_r; nrow=1, npad=20, fillvalue=colorant"white")

plain_diffview = @. img - img_r

RGB_diffview = colorview(RGB, channelview(img), channelview(img_r), fill(0., size(img)))

Gray_diffview = Gray.(RGB_diffview)

mosaicview(plain_diffview, RGB_diffview, Gray_diffview;
           nrow=1, npad=20, fillvalue=colorant"white")

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

