#!/bin/bash

source ShellBot.sh

ShellBot.init --token $token --monitor --flush --return map
ShellBot.username

#_____ _   _ _   _  ____ ___  _____ ____  
#|  ___| | | | \ | |/ ___/ _ \| ____/ ___| 
#| |_  | | | |  \| | |  | | | |  _| \___ \ 
#|  _| | |_| | |\  | |__| |_| | |___ ___) |
#|_|    \___/|_| \_|\____\___/|_____|____/ 

unset btn_all 

btn_all='
["/settargert","/setinfra","/setpeople"],
["/namp","/shodan","/whois"],
["/karma","/sherlok","/theharvester"],
["/advanced","/admin","/commands","/showinfra","/showpeople"]
'

btn_people='
["/karma","/sherlok","/theharvester"]
'
btn_infrastructure='
["/nmap","/inurl"],
["/shodan","/whois"] 
'
btn_agv='
["args-nmap"] 
'

btn_target='["People 👨‍💻","Infrastructure 🖥"]'

btn_advanced='["args-nmap"]'

btn_clean='
["Clean Target - People"],
["Clean Target - Infrastructure"],
["Clean All","Clean Args"]
'

keyboard="$(ShellBot.ReplyKeyboardMarkup --button 'btn_all' --one_time_keyboard true)"
keyboard_infrastructure="$(ShellBot.ReplyKeyboardMarkup --button 'btn_infrastructure' --one_time_keyboard true)"
keyboard_people="$(ShellBot.ReplyKeyboardMarkup --button 'btn_people' --one_time_keyboard true)"
keyboard_agv="$(ShellBot.ReplyKeyboardMarkup --button 'btn_agv' --one_time_keyboard true)"

while :
do

    ShellBot.getUpdates --limit 100 --offset $(ShellBot.OffsetNext) --timeout 30
    for id in $(ShellBot.ListUpdates)
    do

	(
	[[ ${message_chat_type[$id]} != private ]] && continue
	mkdir /tmp/${message_from_id[$id]}
        target_dir=/tmp/${message_from_id[$id]}/target
        target_shell=/tmp/${message_from_id[$id]}/shell
        target_dir_p=/tmp/${message_from_id[$id]}/target_people
        target=$(< $target_dir)
	target_p=$(< $target_dir_p)
	arg_nmap_dir=/tmp/${message_from_id[$id]}/nmap-agr
	arg_nmap=$(< $arg_nmap_dir)
	
	case ${message_text[$id]} in
		'/start')
        	 msg="Hi *$message_from_username* , Let's do a recon ? ?\n"
       	 	 msg+="Your frist time ? Go to /commands"
       		 ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
		 			--text "$(echo -e $msg)"		\
					--parse_mode markdown
		 ShellBot.sendAnimation --chat_id ${message_from_id[$id]}	\
			 		--animation CgADBAADZwEAAjChrFDUjQYY3y3knBYE
		;;
		
		'/readme')
		msg=""
                ShellBot.sendMessage   --chat_id ${message_from_id[$id]}       \
                                        --text "$(echo -e $msg)"               \
                                        --parse_mode markdown
		;;	

		'/help')
        	 msg="Salve *$message_from_username* , Bora fazer um recon ?\n"
       	 	 msg+="Da uma olhada nas info em  /comandos."
       		 ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
		 			--text "$(echo -e $msg)"		\
					--parse_mode markdown
		;;

		"/nmap "*) 
		message_text=$(echo "$message_text" | awk '{print $2}') 
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
		                        --parse_mode markdown			\
					--text "Executing *NMAP* \\n Target = *$message_text* Wait =)"   
		nmap_result=$(nmap $arg_nmap $message_text)
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--text "$nmap_result"  
		;; 

		'/nmap')
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
				        --parse_mode markdown			\
					--text "Executing *NMAP* \\n Target = *$target* Wait =)"   
		nmap_result=$(nmap $arg_nmap $target)
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--text "$nmap_result"  
		;;

		"/theharvester "*) 
		message_text=$(echo "$message_text" | awk '{print $2}') 
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--parse_mode markdown			\
					--text "Executing *The Harvester* \\n Target = *$message_text* Wait =)"   
		theharvester_result=$(theHarvester.py -d $message_text -l 50 -b google)
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--text "$theharvester_result"  
		;;

		'/theharvester')
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--parse_mode markdown			\
					--text "Executing *The Harvester* \\n Target = *$target* Wait =)"   
		theharvester_result=$(theharvester -d  $target -l 50 -b google)
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--text "$theharvester_result"  
		;;

		"/inurl "*)
		message_text=$(echo "$message_text" | awk '{print $2}') 
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--text "Dork - $message_text Aguarde =)"   
		inurl_result=$(inurl $message_text)
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--text "$inurl_result"  
		;;

		"/whois "*) 
		message_text=$(echo "$message_text" | awk '{print $2}') 
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--parse_mode markdown			\
					--text "Executing *Whois* \\n Target = *$message_text* Wait =)"   
		whois_result=$(whois $message_text)
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--text "$whois_result"  
		;;

		'/whois')
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--parse_mode markdown			\
					--text "Executing *Whois* \\n Target = *$target* Wait =)"   
		whois_result=$(whois $target)
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--text "$whois_result"  
		;;

		'/shodan')
		if [ ! -f target_dir=/tmp/${message_from_id[$id]}/shodan.init ] ; then
			shodan init $shodan_key
			> /tmp/${message_from_id[$id]}/shodan.init
		fi 
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--parse_mode markdown			\
					--text "Executing *Shodan* \\n Target = *$target* Wait =)"   
		shodan_result=$(shodan host $target)
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--text "$shodan_result"  
		;;

		"/shodan "*)
		message_text=$(echo "$message_text" | awk '{print $2}') 
		if [ ! -f target_dir=/tmp/${message_from_id[$id]}/shodan.init ] ; then
			shodan init $shodan_key
			> /tmp/${message_from_id[$id]}/shodan.init
		fi 
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--parse_mode markdown			\
					--text "Executing *Shodan* \\n Target = *$message_text* Wait =)"   
		shodan_result=$(shodan host $message_text)
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--text "$shodan_result"  
		;;

		'/karma')
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--parse_mode markdown			\
					--text "Starting *TOR*" 
		service tor start && sleep 5 
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--parse_mode markdown			\
					--text "Executing *Karma* \\nTarget = *$target_p* Wait =)"   
		karma target $target_p > /tmp/karma.log
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--text "\`\`\`$(cat /tmp/karma.log) \\n \`\`\`" \
                                        --parse_mode markdown
		pkill tor && service tor stop
		;;

		"/karma "*)
		message_text=$(echo "$message_text" | awk '{print $2}') 
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--parse_mode markdown			\
					--text "Starting *TOR*" 
		service tor start && sleep 5 
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--parse_mode markdown			\
					--text "Executing *Karma* \\n Target = *$message_text* Wait =)" 
		karma target $message_text > /tmp/karma.log
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--text "\`\`\`$(cat /tmp/karma.log) \\n \`\`\`" \
                                        --parse_mode markdown
		pkill tor && service tor stop
		;;

		'/sherlok')
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--parse_mode markdown			\
					--text "Executing *Sherlok* \\nTarget = *$target_p* Wait =)"

		sherlock $target_p | grep + > /tmp/sheklok.log
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 			\
					--text "\`\`\`$(cat /tmp/sheklok.log) \`\`\`" 		\
                                        --parse_mode markdown
		;;

		"/sherlok "*)
		message_text=$(echo "$message_text" | awk '{print $2}') 
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--parse_mode markdown			\
					--text "Executing *Sherlok* \\n Target = *$message_text* Wait =)"   
		sherlock $message_text | grep + > /tmp/sheklok.log
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 			\
					--text "\`\`\`$(cat /tmp/sheklok.log) \`\`\`" 		\
                                        --parse_mode markdown
		;;

		'/pwnedornot')
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--parse_mode markdown			\
					--text "Executing *Pwnedornot* \\n Target = *$target_p* Wait =)"   
		pwnedornot_result=$(pwnedornot.py -e $target)
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--text "$pwnedornot_result"  
		;;

		"/pwnedornot "*)	
		message_text=$(echo "$message_text" | awk '{print $2}') 
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--parse_mode markdown			\
					--text "Executing *Pwnedornot* \\n Target = *$message_text* Wait =)"   
		pwnedornot_result=$(pwnedornot.py -e $message_text)
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--text "$pwnedornot_result"  
		;;


		'/dorks')
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--text "Lista TOP DORKS"   
		dorks_result=$(cat dorks.list)
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--text "$dorks_result"  
		;;

		'/commands')
		msgp="For *People* \n"
		msgp+="/theharvester - E-mails, subdomains and names Harvester - OSINT\n"
		msgp+="/karma - Find leaked emails with your passwords\n"
		msgp+="/pwnedornot - pwnedornot passwords hacked-emails\n"
		msgp+="/sherlok - Find Usernames Across Social Networks\n"
		msgi="For *Infrastructure* \n"
		msgi+="/nmap  - Open-source network scanner \n"
		msgi+="/shodan - Shodan is the world's first search engine for Internet-connected devices\n"
		msgi+="/inurl  - (Working) Advanced search in search engines, enables analysis provided to exploit\n"	
		msgi+="/dorks  - \n"
		msgi+="/whois  - Research domain ownership with Whois Lookup\n"
		msgt="To define your target \n"
		msgt+="/settarget - Define Target\n"
		msgt+="/showinfra - Define Target Infra\n"
		msgt+="/showpeople - Define Target People\n"
		msgs="Alsos *Shotcuts* \n"
		msgs+="/btninfra - Keyboard to infra\n"
		msgs+="/btnpeople - Keyboard to people\n"
		msgs+="/btnall - Keyboard all\n"
		msga="Set your args for commands (beta)\n"
		msga+="/advanced (beta)\n"
		msgc="Clean confis \n"
		msgc+="/clean"

		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]}	\
					--text "$(echo -e $msgp)"		\
					--parse_mode markdown
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]}	\
					--text "$(echo -e $msgi)"		\
					--parse_mode markdown
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]}	\
					--text "$(echo -e $msgt)"		\
					--parse_mode markdown
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]}	\
					--text "$(echo -e $msgs)"		\
					--parse_mode markdown
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]}	\
					--text "$(echo -e $msga)"		\
					--parse_mode markdown
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]}	\
					--text "$(echo -e $msgc)"		\
					--parse_mode markdown
		;;

		"/shell "*)
		message_text=$(echo "$message_text" | sed -e 's/\/shell //') 
		$message_text > $target_shell 2> $target_shell
		ShellBot.sendMessage 	--chat_id $message_chat_id 		\
					--text "$(echo -e Execution *Output*)" 	\
					--parse_mode markdown
		ShellBot.sendMessage 	--chat_id $message_chat_id 		\
					--text "$(cat $target_shell)"
		> $target_shell
		;;

		'/btnall')
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--text "All shortcuts" 		\
        				--reply_markup "$keyboard" 		\
					--parse_mode markdown
		;;

		'/btnpeople')
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--text "Shortcuts for peoples" 		\
        				--reply_markup "$keyboard_people" 	\
					--parse_mode markdown
		;;

		'/btninfra')
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--text "Shortcurts for Infrastructure" 	\
        				--reply_markup "$keyboard_infrastructure" 	\
					--parse_mode markdown
		;;
		'/advanced')
		ShellBot.sendMessage	--chat_id ${message_from_id[$id]} 	\
					--text "For what command  ?" 		\
					--reply_markup "$(ShellBot.ReplyKeyboardMarkup --button 'btn_agv')"
		;;
		

	        'args-nmap')
		ShellBot.sendMessage	--chat_id ${message_from_id[$id]} 	\
					--text "What args to NMAP" 	\
					--reply_markup "$(ShellBot.ForceReply)"
		unset btn_agv
		;;
		'/settarget')
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 		\
				     	--text "What target?"			\
					--reply_markup "$(ShellBot.ReplyKeyboardMarkup --button 'btn_target')" 
		;;

		"/setpeople "*)
		message_text=$(echo "$message_text" | awk '{print $2}') 
		echo $message_text > $target_dir_p
		ShellBot.sendMessage	--chat_id ${message_from_id[$id]} 	\
					--text "Target = $message_text" 	\
       					--reply_markup "$keyboard_people" 	\
					--parse_mode markdown
		;;

		"/setinfra "*)
		message_text=$(echo "$message_text" | awk '{print $2}') 
		echo $message_text > $target_dir
		ShellBot.sendMessage	--chat_id ${message_from_id[$id]} 	\
					--text "Target = $message_text" 	\
        				--reply_markup "$keyboard_infrastructure" \
					--parse_mode markdown
		;;

		'/showinfra')
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 		\
					--parse_mode markdown				\
				     	--text "Target = *$target*"
		;;

		'/showpeople')
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 		\
					--parse_mode markdown				\
				     	--text "Target = *$target_p*"
		;;

		*"People 👨‍💻"*)
		ShellBot.sendMessage	--chat_id ${message_from_id[$id]} 	\
					--text 'PEOPLE - What email or Username?' \
					--reply_markup "$(ShellBot.ForceReply)"
		unset btn_target 
		;;

		*"Infrastructure 🖥"*)
		ShellBot.sendMessage	--chat_id ${message_from_id[$id]}  	\
					--text 'INFRASTRUCTURE - What IP or domain?' \
					--reply_markup "$(ShellBot.ForceReply)"
		unset btn_target 
		;;

		'/clean')
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
				     	--text "What do you want to clean ?"		\
					--reply_markup "$(ShellBot.ReplyKeyboardMarkup --button 'btn_clean')" 
		;;

		'Clean Target - People')
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
				     	--text "Target People clean"		\
					--reply_markup "$(ShellBot.ReplyKeyboardRemove)" \
					--parse_mode markdown
		> $target_dir_p

		;;

		'Clean Target - Infrastructure')
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
				     	--text "Target Infrastructure clean"		\
					--reply_markup "$(ShellBot.ReplyKeyboardRemove)" \
					--parse_mode markdown
		> $target_dir
		;;

		'Clean All')
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
				     	--text "All clear"			\
					--reply_markup "$(ShellBot.ReplyKeyboardRemove)" \
					--parse_mode markdown
		> $target_dir_p
		> $target_dir
		> $arg_nmap_dir
		;;

		'Clean Args')
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
				     	--text "Args clean"			\
					--reply_markup "$(ShellBot.ReplyKeyboardRemove)" \
					--parse_mode markdown
		> $arg_nmap_dir		
		;;

		'/keyoff')
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 		\
					--text "Removed"				\
					--reply_markup "$(ShellBot.ReplyKeyboardRemove)" \
					--parse_mode markdown
		;; 
		/*)	
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 		\
				     	--text "Invalid commands try /commands"

	esac

	if [[ ${message_reply_to_message_message_id[$id]} ]]; then
		case $message_text in
			"nmap"*)		
			ShellBot.sendMessage	--chat_id ${message_from_id[$id]} 	\
						--text "What args to NMAP" 	\
						--reply_markup "$(ShellBot.ForceReply)"
			;;
			'theharvester')
			ShellBot.sendMessage	--chat_id ${message_from_id[$id]} 	\
						--text 'What args to  HARVESTER' 			\
						--reply_markup "$(ShellBot.ForceReply)"
			;;
		esac
		case ${message_reply_to_message_text[$id]} in
			*"NMAP"*)
			echo $message_text > $arg_nmap_dir
			ShellBot.sendMessage	--chat_id ${message_from_id[$id]} 	\
						--text "Teus args $message_text" 	\
						--reply_markup "$keyboard_infrastructure"  \
						--parse_mode markdown
						
			;;

			*"target"*)
			echo $message_text > $target_dir
			ShellBot.sendMessage	--chat_id ${message_from_id[$id]} 	\
						--text "Target = $message_text" 	\
			;;
			'PEOPLE - What email or Username?')
			echo $message_text > $target_dir_p
			ShellBot.sendMessage	--chat_id ${message_from_id[$id]} 	\
						--text "Target = $message_text" 	\
        					--reply_markup "$keyboard_people" 	\
						--parse_mode markdown
			;;

			'INFRASTRUCTURE - What IP or domain?') 
			echo $message_text > $target_dir
			ShellBot.sendMessage	--chat_id ${message_from_id[$id]} 	\
						--text "Target = $message_text" 	\
        					--reply_markup "$keyboard_infrastructure" 	\
						--parse_mode markdown
			;;

		esac
	fi
	) &
	done
done
