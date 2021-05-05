using Images, ImageEdgeDetection, Noise
using ImageEdgeDetection: Percentile
using TestImages

function make_simple_image(sz)
    img_gray = zeros(Gray{Float64}, sz...)
    fill_region = map(x->x÷4:3x÷4, sz)
    img_gray[fill_region...] .= 1
    img_rot = imrotate(img_gray, pi/4)

    # Corrupt the image with blur and noise, it makes our canny edge detection
    # function works a little harder since the canny filter is based on the idea
    # of finding gradients.
    img_gauss = imfilter(img_rot, Kernel.gaussian(2))

    # We use `salt_pepper` filter from `Noise.jl`. Salt-and-pepper noise in general
    # is a noise that modifies a pixel with two different values of noise.
    # Here we only random set pixels to white.
    img_noise = salt_pepper(img_gauss, 0.05, salt_prob = 0, pepper = 0.9)
end
img = make_simple_image((200, 200))

alg = Canny(spatial_scale=1, high=Percentile(80), low=Percentile(20))

edges = detect_edges(img, alg)
mosaicview(img, edges; nrow=1)

cameraman = testimage("cameraman")
canny(σ) = Canny(spatial_scale=σ, high=Percentile(80), low=Percentile(20))
simple_results = map(σ->detect_edges(img, canny(σ)), 1:5)
cameraman_results = map(σ->detect_edges(cameraman, canny(σ)), 1:5)

mosaicview(
    mosaicview(img, cameraman),
    map(mosaicview, simple_results, cameraman_results)...;
    nrow=1
)

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

