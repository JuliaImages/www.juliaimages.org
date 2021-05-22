# ---
# title: Image Difference View
# cover: assets/image_diffview.png
# author: Johnny Chen
# date: 2020-03-07
# ---

# This demonstration shows some common tricks in image comparision -- difference view

# People with MATLAB experiences would miss the function
# [`imshowpair`](https://www.mathworks.com/help/images/ref/imshowpair.html), but in JuliaImages
# it is not that indispensable.

using Images
using TestImages

img = float.(testimage("cameraman"))
## rotate img by 4 degrees and keep axes unchanged
img_r = imrotate(img, -pi/45, axes(img))
nothing #hide #md

# `mosaicview` is a convenience tool to show multiple images, especially useful when they have
# different sizes and colors.

mosaicview(img, img_r; nrow=1, npad=20, fillvalue=colorant"white")

# In some cases, when the differences of two images are relative insignificant, a plain
# substraction can help amplify the difference.
plain_diffview = @. img - img_r
nothing #hide #md

# For gray images, a fancy trick is to fill each image into different RGB channels
# and make a RGB view. [`zeroarray`](@ref ImageCore.zeroarray) is a constant which
# serves as a placeholder to create a (virtual) all-zeros array of size that matches
# the other arguments.
RGB_diffview = colorview(RGB, channelview(img), channelview(img_r), zeroarray)
nothing #hide #md

# or convert the RGB view back to Gray image after that
Gray_diffview = Gray.(RGB_diffview)

mosaicview(plain_diffview, RGB_diffview, Gray_diffview;
           nrow=1, npad=20, fillvalue=colorant"white")


# --- save covers --- #src
using FileIO #src
save("assets/image_diffview.png", map(clamp01nan, RGB_diffview)) #src
