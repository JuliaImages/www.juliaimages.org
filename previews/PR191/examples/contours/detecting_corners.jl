using Images, TestImages
img = Gray.(testimage("house"))

corners = imcorner(img)
img_copy = RGB.(img)
img_copy[corners] .= RGB(1.0, 0.0, 0.0)
img_copy

corners = imcorner(img, Percentile(98.5))
img_copy2 = RGB.(img)
img_copy2[corners] .= RGB(1.0, 0.0, 0.0)
img_copy2

detection_methods = [harris, shi_tomasi, kitchen_rosenfeld]
img_copies = [RGB.(img) for i in 1:length(detection_methods)]
for i in 1:length(detection_methods)
    corners = imcorner(img, Percentile(98.5); method=detection_methods[i])
    img_copies[i] = RGB.(img)
    img_copies[i][corners] .= RGB(1.0, 0.0, 0.0)
end
mosaicview(img_copies; nrow=1)

corners = fastcorners(img, 11, 0.1) # fastcorners(img, n, t) where n and t are optional
img_copy3 = RGB.(img)
img_copy3[corners] .= RGB(1.0, 0.0, 0.0)
img_copy3

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

