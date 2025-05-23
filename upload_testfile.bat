@echo off
setlocal

:: === Configuration ===
set CURL_PATH=curl\curl.exe
set CERT_FILE=certs\kommunA.crt
set CA_FILE=certs\ExpiTrust-EID-CA-v4.pem
set UPLOAD_FILE=testfile.xml
set URL=https://shs.test.skatteverket.se/et/et_web/auto/cc790fee-7d68-008c-3c17-5682d2bdff5a/

:: === Output Files ===
set TRACE_FILE=trace.txt
set RESPONSE_FILE=response.txt

:: === Run curl with trace and response capture ===
echo Uploading %UPLOAD_FILE%...
%CURL_PATH% ^
  --cert "%CERT_FILE%" ^
  --cacert "%CA_FILE%" ^
  -T "%UPLOAD_FILE%" ^
  --trace-ascii "%TRACE_FILE%" ^
  --output "%RESPONSE_FILE%" ^
  "%URL%"

echo.
echo === Upload complete ===
echo Trace saved to: %TRACE_FILE%
echo Response saved to: %RESPONSE_FILE%

endlocal
pause
