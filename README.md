# Reccoon Bot 

<p align="center">
  <h3 align="center">Reccoon Bot</h3>
  <p align="center">is a telegram bot with an OSINT toolkit.</p>
</p>

<hr>


### Getting Started

```
In reccoon bot is possible run in two ways:
```

### Running local

```
To run local you must set the variable token.
```

```
export shodan_key="Your shodan key"
export token="Your KEY"
./bot.sh
```

### Running in Docker
```
docker run --env token="Your KEY" --env shodan_key="Shodan KeY" St0rm-security/reconbot
```

# In the bot 

```
In bot the tools are separated into two groups:
You can use the tools as follows:
```

Using target as argument:

```bash
/nmap scanme.nmap.org
```

**Or**

Setting your target with /setinfra /setpeople /settarget.

```bash
/settarget 
select "infra" 
entry your target 
/nmap
```  

## For development
To enter the branch **dev** you will need to be in the project directory and perform the command.

```sh
git checkout dev
```

To view which branch it is in can be used.

```sh
git branch
```
### The result will be something like.

```sh
$ git branch
* dev
  master
```
  
