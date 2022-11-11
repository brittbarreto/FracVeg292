# Data Preparation Environment Setup

This document will explain how to set up a JupyterLab-enabled Python environment on a remote server (like Pinto) that you can access from your local machine.

## Python Setup

1. SSH into the server (nothing special here).

    ```bash
    ssh your_username@pinto.ucmerced.edu
    ```

2. Navigate to the project location:

    ```bash
    cd /<project location>/prep-scripts
    ```

5. Set up Python and Miniconda using the provided script. You can edit the environment variables defined in `setup-python.sh` to customize your installation.

    - If on a standard system:

        ```bash
        ../util-scripts/setup-python.sh
        ```

    - If on a [SLURM](https://slurm.schedmd.com/documentation.html)-enabled system (you will have to adjust the parameters to work with your cluster):

        ```bash
        sbatch \
            --partition "main" \
            --nodes=1 \
            --ntasks=1 \
            --cpus-per-task=16 \
            --mem=65536 \
            --job-name="setup_python" \
            --output="python_setup.out" \
            --time="05:00:00" \
            ../util-scripts/setup-python.sh
        ```

6. Add the correct version of Python to your PATH:

    You should be able to copy/paste this from the output of the Python install script (yours may look different; it will tell you *exactly* which command to run).

    ```bash
    source ./conda/etc/profile.d/conda.sh
    ```

7. Create a virtual environment and install project dependencies using the `environment.yml` file:

    For Anaconda:
    ```bash
    conda env create -f environment.yml
    ```

## Start Jupyter

1. Now that your environment is set up, we can start the Jupyter Lab server so that you can access and run notebooks remotely. You can start Jupyter Lab with the following command. Make to choose a port number that nobody else is using (and replace `<your port number>` with your choice). Usually, this is a **4-digit** number such as `4273`.

    ```bash
    jupyter lab --ip=0.0.0.0 --port=<your port number>
    ```

2. Jupyter will output a bunch of information. **You will need to take note of the "token" as you'll need it to sign into your Jupyter Lab environment!** For example, if my output looks like this:

    ```log
    ...

    Or copy and paste one of these URLs:
        http://localhost:8888/lab?token=f29d7ffe0a0726cba964436e0f63b01699e41e9efec67924
     or http://127.0.0.1:8888/lab?token=f29d7ffe0a0726cba964436e0f63b01699e41e9efec67924
    ```

    Then I know that my token is:

    ```log
    f29d7ffe0a0726cba964436e0f63b01699e41e9efec67924
    ```

## On Your Local Machine

1. Use SSH to forward requests from your local machine to Jupyter running on the server. Replace `<your port number>` with the port number you chose in Step 2 of the ["Start Jupyter Lab"](#start-jupyter-lab) section.

    ```bash
    ssh -R <your port number>:localhost:<your port number> <username>@<server hostname>
    ```

2. **(Option 1)** Connect to your Jupyter Lab instance through your browser by navigating to the following URL. Make sure to replace `<your port number>` and `<your token>` with the appropriate values.

    ```text
    http://localhost:<your port number>/lab?token=<your token>
    ```

    You should see the Jupyter Lab interface!

3. **(Option 2)** Connect to your Jupyter Lab instance with Visual Studio Code. Refer to the [VS Code documentation](https://code.visualstudio.com/docs/datascience/jupyter-notebooks#_connect-to-a-remote-jupyter-server).
