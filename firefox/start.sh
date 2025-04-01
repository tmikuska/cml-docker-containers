#!/bin/bash

function check() {
    URL="$1"
    MAX_RETRIES=10
    TIMEOUT=1
    attempt=0

    if [ -z "$URL" ]; then
        exit 1
    fi

    echo "Check and wait for $URL to become available..."

    while [ $attempt -lt $MAX_RETRIES ]; do
        attempt=$((attempt + 1))
        response=$(curl --silent --head --max-time $TIMEOUT --write-out "%{http_code}" --output /dev/null "$URL")
        curl_exit_code=$?
        if [ $curl_exit_code -ne 0 ]; then
            if [ $curl_exit_code -eq 28 ]; then
                echo "Attempt ${attempt}: Timeout occurred."
            else
                echo "Attempt ${attempt}: Curl encountered an error (code: $curl_exit_code)."
            fi
        elif [ "$response" -ne 200 ]; then
            echo "Attempt ${attempt}: Non-200 HTTP response: $response."
        else
            echo "URL retrieved successfully with HTTP status 200."
            return 0
        fi
        sleep 1
    done

    return 1
}

if ! check $HOME_URL; then
    HOME_URL=""
fi

# optional wait
case "$WAIT" in
    '' | *[!0-9]*)
        # Not a number, do nothing
        ;;
    *)
        if [ "$WAIT" -gt 0 ]; then
            sleep "$WAIT"
        fi
        ;;
esac

# start i3 and firefox
/usr/bin/i3 &
/usr/bin/firefox-esr $HOME_URL &

# wait for firefox window
while ! xdotool search --name "Firefox"; do
    sleep 1
done

# send fullscreen command to i3
i3-msg fullscreen

# wait for Firefox to exit
wait $!
