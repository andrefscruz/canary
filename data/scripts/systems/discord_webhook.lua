-- Sends Discord webhook notifications.
-- The URL layout is https://discord.com/api/webhooks/:id/:token
-- Leave empty if you wish to disable.

if not announcementChannels then
	announcementChannels = {
		["serverAnnouncements"] = "https://discord.com/api/webhooks/1308265803786878976/9xaRTCrvPhbGuxSRcFA2_fTt9eXRDubCKfAtf99BXPnlSFohWlqlsKL8QFzjsqOL1qi5", -- Used for an announcement channel on your discord
		["raids"] = "https://discord.com/api/webhooks/1308263054139457536/vjsg4vMsUXOBDjM0IVcJFks8_aSb6zzViCXgVhngC536CX6RjuOb35MRCaUexn2qrR8-", -- Used to isolate raids on your discord
		["player-kills"] = "https://discord.com/api/webhooks/1308265684618444911/gYyk4Re4L_MCAoxbMOOLfiezkt8Adbq92CSjqdm8cKpkDMb6IFoPMypEPt1qDly96FSn", -- Self-explaining
		["player-levels"] = "https://discord.com/api/webhooks/1306718696999227452/6L-JRAr5XiX52Sg5TZ4hInnAVQo5gxl3OlQW04oZu37L77VNCfoIHod6XP-aZ-vJi1jJ", -- Self-explaining
		["reports"] = "https://discord.com/api/webhooks/1306718923651154011/uyeKMhffO5V_ZATl4VYhaL6FFOJqMyw7WbYyggahvrdH6zPWGY_QiMWEo0xBM9u5gZP_",
		["log-roullets"] = "https://discord.com/api/webhooks/1308262557043134464/Fa_cfghSod6zXjfjuYkqqZA4pkebSgZk19RSBTXKY4Esl_AteiYkZ53JHcVmNN4MtDIk",
		["log-bans"] = "https://discord.com/api/webhooks/1308263498521776160/tWj4jpDmqN4ElUPPor3y86uj_BJKSlCYpbe4QiT_LqVmZkYPo39qhn1v_T8Py7tyM5vC",
		["log-gms"] = "https://discord.com/api/webhooks/1308264655847686184/2rAJV_xrLwec7KiiX-FwNLJqJP8sfBNBNf_ixXRpuYc_2IoyG9HqllCYCpaInzgCx1XS",
		["log-bags"] = "https://discord.com/api/webhooks/1308272671074553876/ErC8GLjBiwLlyn_JhSdvb1Fw1jfsl9aAM8F6TidQZSO1AFXNyU1Owvf0v-lhJn8MjZg5",
		["log-chests"] = "https://discord.com/api/webhooks/1308278310513414145/W2bn4MuJdsjAmfyP6WrlXUzk7QKc7jBxeiJOiI-z1gDcIxt9dpKAZAUPlAS0KqLezgdJ",
		["log-rares"] = "https://discord.com/api/webhooks/1309278111224827984/k0xo3hJPqyhkrfyWefNv4wUqVRPs6ktO8BK0jbMhfrZ_daII012KN6OWMhZqfkedXoJ4",
	}
end

--[[
	Example of notification (After you do the config):
	This is going to send a message into your server announcements channel

	local message = blablabla
	local title = test
	Webhook.sendMessage(title, message, WEBHOOK_COLOR_YELLOW,
                        announcementChannels["serverAnnouncements"])

	Dev Comment: This lib can be used to add special webhook channels
	where you are going to send your messages. Webhook.specialSend was designed
	to be used with countless possibilities.
]]
