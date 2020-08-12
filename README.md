# Docker
Various Docker-related content such as shellscripts, Dockerfiles and the like. Not necessarily up-to-date or even working. Use at your own risk, apply some common sense.

As of now, only the `ccminer-verus`, `hellminer-verus` and `nheqminer-verus-{binary,source}` Dockerfiles are maintained. See the `unmaintained/` directory for the others. **Note that `README.md` files there within may contain outdated information.**

## Image sizes

All images are based on `debian:buster-slim`

```
REPOSITORY               TAG                 IMAGE ID            CREATED              SIZE
ccminer-verus            latest              c1ca9c052dba        About a minute ago   83.7MB
nheqminer-verus-source   latest              72848f86fac9        10 minutes ago       78.7MB
nheqminer-verus-binary   latest              791888b81707        27 minutes ago       79.4MB
hellminer-verus          latest              64fb22210d3f        28 minutes ago       83.2MB
debian                   buster-slim         c7346dd7f20e        7 days ago           69.2MB
```
