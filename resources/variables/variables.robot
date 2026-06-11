*** Variables ***
# --- Web ---
${BASE_URL}             https://www.saucedemo.com
${BROWSER}              chrome
${HEADLESS}             ${False}
${IMPLICIT_WAIT}        10s

# --- Standard users ---
${STANDARD_USER}        standard_user
${STANDARD_PASS}        secret_sauce
${LOCKED_USER}          locked_out_user

# --- API ---
${API_BASE_URL}         https://reqres.in/api
${API_TIMEOUT}          10s
${REQRES_API_KEY}       %{REQRES_API_KEY=}

# --- Timeouts ---
${ELEMENT_TIMEOUT}      15s
${PAGE_LOAD_TIMEOUT}    30s
