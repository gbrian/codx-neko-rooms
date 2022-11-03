bash $HOME/apps/python.sh
pip install jupyterlab
$HOME/.local/bin/jupyter notebook stop 8888
$HOME/.local/bin/jupyter notebook --generate-config
sed -i "s/\# c.NotebookApp.ip = 'localhost'/c.NotebookApp.ip = '0.0.0.0'/" .jupyter/jupyter_notebook_config.py
$HOME/.local/bin/jupyter-lab

