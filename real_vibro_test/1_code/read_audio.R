# library("readr")
# library("tuneR")

if(vibration ==T){
    d1 = rmatio::read.mat("../../data/VIBRO/data 1/healthy/H-A-1.mat")
    d2 = rmatio::read.mat("../../data/VIBRO/data 1/healthy/H-B-1.mat")
    # d2 = rmatio::read.mat("../../data/VIBRO/bearing data/normal_2.mat")
    # d3 = rmatio::read.mat("../../data/VIBRO/bearing data/IR014_2.mat")
    # d4 = rmatio::read.mat("../../data/VIBRO/bearing data/B007_3.mat")
    # d5 = rmatio::read.mat("../../data/VIBRO/bearing data/B021_1.mat")
    
    
    
    
    d = c(d1$Channel_1,
          d2$Channel_1)
    
    s_orig = d
    
    s_orig=signal::decimate(s_orig, 10 )
    
    if (graph == T) {
        png(filename = paste0("../3_figures/vibration.png")
            , width = 2048, height = 1024)
        
        par(mfrow=c(1,1))
        plot(s_orig, type = 'l',
             ylab = "value", main = "Vibration signal")
        dev.off()
        
        plot(s_orig, type = 'l',
             ylab = "value", main = "Vibration signal")
    }
    ###### 
    
    cat("\n", 'Original signal decimated by 10', '\n',
        '--------------------------------', '\n',
        'Decimated sgnal LOADED and SAVED!')
} else{
    
    sound = tuneR::readWave(filename = name)
    # sound2 = readWave(filename = "../../data/audio/virdulys_2.wav")
    
    # str(sound)
    
    # converte soud array
    s1 <- sound@left / 2^(sound@bit -1)
    # s2 <- sound2@left / 2^(sound2@bit -1)
    
    # x axis (seconds)
    # timeArray <- (0:(length(sound@left)-1)) / sound@samp.rate
    # timeArray2 <- (0:(length(sound2@left)-1)) / sound2@samp.rate
    
    # plot(timeArray, s1, type = 'l')
    # plot(timeArray2, s2, type = 'l')
    
    # par(mfrow=c(1,1))
    # plot.ts(s1[48000:96000])
    # plot.ts(s2[48000:96000])
    
    
    # audio_1 <- s1[1:135000]
    # audio_2 <- s2[1:135000]
    
    # s = c(audio_1, audio_2)
    
    s_orig = s1
    
    
    s_orig=signal::decimate(s_orig, 10 )
    
    if (graph == T) {
        png(filename = paste0("../3_figures/",audio, ".png")
            , width = 2048, height = 1024)
        
        par(mfrow=c(1,1))
        plot(s_orig, type = 'l',
             ylab = "value", main = "Acoustic signal")
        dev.off()
        
        plot(s_orig, type = 'l',
             ylab = "value", main = "Acoustic signal")
    }
    ###### 
    
    cat("\n", 'Original signal decimated by 10', '\n',
        '--------------------------------', '\n',
        'Decimated sgnal LOADED and SAVED!')
}



