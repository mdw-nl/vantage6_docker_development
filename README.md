# How to get started

* Git clone this repo
```
git clone git@github.com:mdw-nl/vantage6_docker.git
```

* Clone submodules (`vantage6` and `vantage6_docker`)
```
git submodule clone
```

* Populate `.egg-link`s and install venv with vantage6 for client testing.
```
./init.sh
```

* Up containers
```
docker compose up -d
```

* Develop code under `vantage6/`! If need be restart a container to get it to pick up modifications.


## TODO

### Fancier fs merging
Our current way of getting the vantage6 code into the container is hacky, but
allows us to not have to re-build every time we make a change. However,
modifications made in the container like:
* `__pycache__/*.pyc` files
* our apply of our patch
Will also happen on the host, as the `/vantage6` is simply volume mapped.
This can get annoying because new files (like .pyc) end up with root:root
permissions on the host, and deleting can be cumbersome.

It would be cool if there was a way to merge live on the container the
"write/read" container layer with the volume mapped one.

### Even fancier fs merging

Further, within the image, there is already a `/vantage6` with all the
`.egg-link`s directories from running `pip` in the Dockerfile. We artificially
recreate this in our `init.sh` by running pip on the host in a virtual
environment, which is a kludgy solution.

So, ideally, it would be cool if we could do a three-way merge of the image
`/vantage6`, the volume mapped one (for changes while developing), and the
container modifications.

### submodules

Keeping in mind to update submodules is not the best..
