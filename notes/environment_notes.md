# Environment / Tool Version Notes

## Working environments
- `unicycler` — see envs/unicycler.yml
- `flye` — see envs/flye.yml (RECOMMENDED for long-read assembly)
- `canu` — see envs/canu.yml (had Java version conflicts, see below)

## Known issues
- Canu requires Java 8 specifically (java-jdk=8.0.92 from bioconda).
  Installing openjdk=11 alongside it breaks the JVM with a symbol lookup
  error. If reinstalling Canu, pin java-jdk=8.0.92 explicitly and avoid
  installing any other JDK in the same environment.
- Flye needs adequate memory for k-mer counting on genome-scale data;
  on WSL2, check .wslconfig memory allocation if you hit OOM kills.
