# What's this?

Scaffolding around vantage6 to create a developemnt environment. Very much under construction and dependent on full dockerization of vantage6 (node included)

# How to get started

* Git clone this repo
```
git clone git@github.com:mdw-nl/vantage6_docker_development.git
```

* Initialize: clone `vantage6` and `vantage6_docker`, populate `.egg-link`s and install venv with vantage6 for client testing.
```
./init.sh
```

* Up containers
```
docker compose up -d
```
:construction: On latest commit, this probably won't work. :P :construction:

* Develop code under `vantage6/`! If need be restart a container to get it to pick up modifications.

# Simple proof of concept test..
* Access http://127.0.6.1:8080
  With the credentials:
  * user: `root`
  * password: `test_just_a_testing_password_initial_root_password_A123.`
  (found under `dev-secrets/initial-root-password`)

  Or with:
  * user: `titan`
  * password: `test-password-cloudy-orbit`
  `titan` is a user of organization Saturn.
  See: `dev-v6-server/custom-start.d/entities.yaml`
* You can also test the API of the vantage6 server itself by navigating to: http://127.0.6.1/api/version
* Give user `titan` Researcher role
* Try running this simple [jupyter notebook](./client/Template_Create_Task.ipynb)

## TODO

### Mainly: settle on design direction for full dockerzation on v6 side
And then adapt this repo for it.

### Fancier fs merging
Our current way of getting the vantage6 code into the container is hacky, but
allows us to not have to re-build every time we make a change. However,
modifications made in the container like:
* ~~`__pycache__/*.pyc` files~~ --> No longer generated with PYTHONDONTWRITEBYTECODE
* ~~our apply of our patch (and patches .orig backup)~~ --> already modified in our experimental branch of vantage6
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

### The whole thing is not robust!

Code speaks for itself, but we have to start somewhere :)


### Macbook M1 changes
To make it work on Apple M1 product some changes are required. You can try https://github.com/mdw-nl/vantage6_docker_development/issues/2
Or just change all the 127.0.6.0/24 IPs to 127.0.0.1 (or omit the IP), and use
different ports for each service.

### Volume map debugpy?

We could pip install (-t) debugpy somewhere like `/opt/debugpy/` and then make
/opt/debugpy a volume. That way we don't have to re-install debugpy every time
we up the container. Perhaps nodes and server can even share the volume, as
long a no state is kept there, which it shouldn't?


