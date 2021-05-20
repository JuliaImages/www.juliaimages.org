using Images, TestImages, OffsetArrays
# ImageTransformations is reexported by Images
# load an example image
img_source = testimage("lighthouse")

img_size = size(img_source)

img_cropped = @view img_source[ :,floor(Int, 1/8*img_size[2]) : floor(Int, 7/8*img_size[2])]

size(img_cropped)

img_padded = PaddedView(
    zero(eltype(img_source)),
    OffsetArray(img_cropped, OffsetArrays.Origin(1, floor(Int, 1/8*img_size[2]))),
    axes(img_source))

img_square = imresize(img_source, (400, 400));
img_small = imresize(img_source, ratio=1/4);
img_medium = imresize(img_small, size(img_small).*2);
mosaicview(img_source, img_square, img_small, img_medium; nrow=1)

percentage_scale = 0.6
new_size = trunc.(Int, size(img_source) .* percentage_scale)
img_rescaled = imresize(img_source, new_size);
mosaicview(img_source, img_rescaled; nrow=1)

new_width = 200
percentage_scale = new_width / size(img_source,2);
new_size = trunc.(Int, size(img_source) .* percentage_scale);
img_rescaled = imresize(img_source, new_size);
mosaicview(img_source, img_rescaled; nrow=1)

rescaled_both = restrict(img_source); # both side
rescaled_height = restrict(img_source, 1); # dims=1, i.e., height dimension
rescaled_width = restrict(img_source, 2); # dims=2, i.e., width dimension
mosaicview(img_source, rescaled_both, rescaled_height, rescaled_width; nrow=1)

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

