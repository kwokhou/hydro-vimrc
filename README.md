# hydro-vimrc
A hydroelectric power vimrc. Efficient and environmental friendly.

Well, this is basically vimrc that I created to help myself, most of the settings are from various vim experts. 

### Prerequisite
* Git
* Curl

### Installation Steps
1. Install [vim-plug](https://github.com/junegunn/vim-plug) (skip this if you already have this)

  ```sh
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  ```

2. Install hydro-vimrc

  ```sh
  curl -o - https://raw.githubusercontent.com/kwokhou/hydro-vimrc/master/install.sh | sh
  ```

3. Run `:PlugInstall` from within vim to install plugins

### License

This project is released under **The MIT License**
