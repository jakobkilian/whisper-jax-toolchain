This is a quick and dirty pipeline for whisper_jax on a A100 Server to transcribe audio files (any format) to continuous text and timestamped text in about 3% of the duration of the original audio. 

# Install and Usage:

1. clone this repository by `git clone `
2. go to the directory with `cd whisper-jax-toolchain`
3. run the "init.sh" script by `./init.sh``
4. put your audio file (mp3, wav, ...) in the directory "input" 
5. open the "transcribe.ipynb" Jupyter Notebook and run cell by cell
6. download output from the directory "output"
