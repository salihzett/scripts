
#!/bin/bash
status=$(./bitwarden.sh renewcert)

SLACKHOOK="HOOK"
SLACKTOKEN="TOKEN"


read -d '' SLACK_PAYLOAD_DATA << EOF
{
    "SLACKCHANNEL": "$SLACKCHANNEL",
    "attachments": [
        {
            "fallback": "Plain-text summary of the attachment.",
            "color": "#efc0aa",
            "pretext": "Hey guys! :wave:",
                        "title": "I have an update for our Bitwarden instance:",
                        "text": "The SSL certification has just been updated. Please <https://www.sslshopper.com/ssl-checker.html#hostname=HOST/|check>.
            }
    ]
}
EOF

check='Congratulations'
if [[ "$status" == *"$check"* ]]; then
        # Send to Slack API
        SLACK_COMMAND="curl -X POST --data-urlencode 'payload=${SLACK_PAYLOAD_DATA}' ${SLACKHOOK}"
        eval ${SLACK_COMMAND}
fi
