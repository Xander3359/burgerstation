/*!
 * Copyright (c) 2020 Aleksej Komarov
 * SPDX-License-Identifier: MIT
 */

/// How many chat payloads to keep in history
#define CHAT_RELIABILITY_HISTORY_SIZE 5
/// How many resends to allow before giving up
#define CHAT_RELIABILITY_MAX_RESENDS 3

#define MESSAGE_TYPE_SYSTEM "system"
#define MESSAGE_TYPE_LOCALCHAT "localchat"
#define MESSAGE_TYPE_RADIO "radio"
#define MESSAGE_TYPE_INFO "info"
#define MESSAGE_TYPE_WARNING "warning"
#define MESSAGE_TYPE_DEADCHAT "deadchat"
#define MESSAGE_TYPE_OOC "ooc"
#define MESSAGE_TYPE_ADMINPM "adminpm"
#define MESSAGE_TYPE_COMBAT "combat"
#define MESSAGE_TYPE_ADMINCHAT "adminchat"
#define MESSAGE_TYPE_PRAYER "prayer"
#define MESSAGE_TYPE_MODCHAT "modchat"
#define MESSAGE_TYPE_EVENTCHAT "eventchat"
#define MESSAGE_TYPE_ADMINLOG "adminlog"
#define MESSAGE_TYPE_ATTACKLOG "attacklog"
#define MESSAGE_TYPE_DEBUG "debug"

/// Max length of chat message in characters
#define CHAT_MESSAGE_MAX_LENGTH 110

//debug printing macros (for development and testing)
/// Used for debug messages to the world

#define debug_world(msg) if (GLOB.Debug2) to_chat(world, \
	type = MESSAGE_TYPE_DEBUG, \
	text = "DEBUG: [msg]")
/// Used for debug messages to the player
#define debug_usr(msg) if (GLOB.Debug2 && usr) to_chat(usr, \
	type = MESSAGE_TYPE_DEBUG, \
	text = "DEBUG: [msg]")
/// Used for debug messages to the admins
#define debug_admins(msg) if (GLOB.Debug2) to_chat(GLOB.admins, \
	type = MESSAGE_TYPE_DEBUG, \
	text = "DEBUG: [msg]")
/// Used for debug messages to the server
#define debug_world_log(msg) if (GLOB.Debug2) log_world("DEBUG: [msg]")
/// Adds a generic box around whatever message you're sending in chat. Really makes things stand out.
#define examine_block(str) ("<div class='examine_block'>" + str + "</div>")

//TODO-TG Replace burger defines with TG stuff
//THIS IS FOR INPUTS
#define TEXT_TALK "talk"
#define TEXT_LOOC "looc"
#define TEXT_OOC "ooc"
#define TEXT_GHOST "ghost"
#define TEXT_BOT "bot"
#define TEXT_RADIO "radio"
#define TEXT_PM "pm"
#define TEXT_PM_ADMIN_IN "admin_in"
#define TEXT_PM_ADMIN_OUT "admin_out"
#define TEXT_RAW "raw"

#define CHAT_TYPE_SAY 0x1
#define CHAT_TYPE_OOC 0x2
#define CHAT_TYPE_LOOC 0x4
#define CHAT_TYPE_COMBAT 0x8
#define CHAT_TYPE_RADIO (CHAT_TYPE_SAY)
#define CHAT_TYPE_PM (CHAT_TYPE_OOC | CHAT_TYPE_LOOC)
#define CHAT_TYPE_DEBUG 0x10

#define CHAT_TYPE_INFO CHAT_TYPE_SAY

#define CHAT_TYPE_ALL 0xFFFFFF

#define CHAT_FONT_SIZE 0.25

#define TALK_TYPE_NONE 0
#define TALK_TYPE_NORMAL "normal"
#define TALK_TYPE_QUESTION "question"
#define TALK_TYPE_EXCLAIMATION "exclaim"
