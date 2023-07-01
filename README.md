# flask-cython-gunicorn-docker

Protect and speed up your python code with cython, gunicorn and docker.

## Building

```docker build --no-cache --secret id=mysecret,src=secret-file -t flask-cython-gunicorn-docker:test .```

*As of Python 3.3, it is no longer necessary to use ```__init__.py``` file, but cython still needs this file to identify modules.*

## Running

```docker run -it -p 3000:3000 --name=test --rm flask-cython-gunicorn-docker:test```

## Inside the container

```docker exec -it test bash```

```
nobody@ad11cd146bc8:/app$ ls
apis  main.cpython-311m-x86_64-linux-gnu.so  requirements.txt
nobody@ad11cd146bc8:/app$ ls apis
__init__.cpython-311m-x86_64-linux-gnu.so  hello_world.cpython-311m-x86_64-linux-gnu.so
```

## Resources

-  [Use Cython to get more than 30X speedup on your Python code](https://towardsdatascience.com/use-cython-to-get-more-than-30x-speedup-on-your-python-code-f6cb337919b6)
-  [Protecting Python Sources With Cython](https://medium.com/@xpl/protecting-python-sources-using-cython-dcd940bb188e)
-  [Distributing python packages protected with Cython](https://medium.com/swlh/distributing-python-packages-protected-with-cython-40fc29d84caf)
-  [Docker multi-stage builds](https://docs.docker.com/develop/develop-images/multistage-build/)
-  [Don’t leak your Docker image’s build secrets](https://pythonspeed.com/articles/docker-build-secrets/)