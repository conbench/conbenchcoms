# Conbench API wrapper

## Installation
conbenchcoms can be installed directly from the repo:

```r
remotes::install_github("conbench/conbenchcoms")
```


  
## Credential Management
There are two ways to pass credentials with r package {conbench} to a specific instance of conbench. Both of these methods make use of environment variables. From R you can open your `.Renviron` you can use the following command: `file.edit("~/.Renviron")`

### Via Three Environment Variables
You can specify each parameter via separate environment variable:

```
CONBENCH_EMAIL="your@email.com"
CONBENCH_URL="url of conbench"
CONBENCH_PASSWORD="yourPassword"
```

### Via DOT_CONBENCH
You'll need a `.conbench` file that has credentials.

Create and open a `.conbench` file using `file.edit("~/.conbench")`. This will open your file. Add the following lines (ignoring comments):

{start of file}
```
url: url of conbench
email: your@email.com
password: yourPassword
```
{end of file}

From there you can add a `"DOT_CONBENCH"` environment variable which points to where you saved that `.conbench` file. For example, in your `.Renviron` file add a line like this:

```
DOT_CONBENCH=~/.conbench
```

