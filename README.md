MNRAS Paper
-----------

**Title**:
Separating the EoR Signal with a Convolutional Denoising Autoencoder:
A Deep-learning-based Method

**Authors**:
Weitian Li,
Haiguang Xu,
Zhixian Ma,
Ruimin Zhu,
Dan Hu,
Zhenghao Zhu,
Junhua Gu,
Chenxi Shan,
Jie Zhu,
Xiang-Ping Wu

**Journal**:
[MNRAS, 2019, 485, 2628](https://dx.doi.org/10.1093/mnras/stz582)

**arXiv**:
[1902.09278](https://arxiv.org/abs/1902.09278)

**ADS**:
[2019MNRAS.485.2628L](http://adsabs.harvard.edu/abs/2019MNRAS.485.2628L)

**Code**:
https://github.com/liweitianux/cdae-eor

**Abstract**:
When applying the foreground removal methods to uncover the faint cosmological
signal from the epoch of reionization (EoR), the foreground spectra are assumed
to be smooth.
However, this assumption can be seriously violated in practice since the
unresolved or mis-subtracted foreground sources, which are further complicated
by the frequency-dependent beam effects of interferometers, will generate
significant fluctuations along the frequency dimension.
To address this issue, we propose a novel deep-learning-based method that uses
a 9-layer convolutional denoising autoencoder (CDAE) to separate the EoR
signal.
After being trained on the SKA images simulated with realistic beam effects,
the CDAE achieves excellent performance as the mean correlation coefficient (ρ̄)
between the reconstructed and input EoR signals reaches 0.929 ± 0.045.
In comparison, the two representative traditional methods, namely the
polynomial fitting method and the continuous wavelet transform method, both
have outstanding difficulties in uncovering the EoR signal, yielding only
ρ̄[poly] = 0.296 ± 0.121 and ρ̄[cwt] = 0.198 ± 0.160, respectively.
We conclude that, by hierarchically learning sophisticated features through
multiple convolutional layers, the CDAE is a powerful tool that can be used to
overcome the complicated frequency-dependent beam effects and accurately
separate the EoR signal, which exhibits the great potential of
deep-learning-based methods in future EoR experiments.
