using ImageContrastAdjustment, TestImages, ImageCore

img = testimage("moonsurface")

hist_equal = adjust_histogram(img, Equalization(nbins = 256))
gamma_correction = adjust_histogram(img, GammaCorrection(gamma = 2))
hist_adapt = adjust_histogram(img, AdaptiveEqualization(nbins = 256, rblocks = 4, cblocks = 4, clip = 0.2))

mosaicview(img, hist_equal, gamma_correction, hist_adapt; nrow = 1)

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

