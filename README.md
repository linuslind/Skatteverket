# SHS Skatteverket Curl Upload Guide (Windows)

This guide helps you upload a test file (`testfil.xml`) to Skatteverket's SHS test environment using `curl` in Windows with mutual TLS authentication.

---

## Prerequisites

- `curl` for Windows (recommended: [latest version with OpenSSL](https://curl.se/windows/))
- A client certificate (`kommunA.crt`)
- A CA certificate in PEM format (`ExpiTrust-EID-CA-v4.pem`)
- File to upload (`testfil.xml`)

---

## Format Requirements

### CA Certificate (PEM)
Skatteverket requires the **CA certificate** to be in **PEM format**.

**If you received a `.cer` file**, it may be in **DER (binary)** format, which `curl` does **not** support.

**To convert `.cer` to `.pem`:**
```sh
openssl x509 -inform DER -in ExpiTrust-EID-CA-v4.cer -out ExpiTrust-EID-CA-v4.pem
```

---

### Client Certificate (`.crt` + optional `.key`)
Use the `.crt` provided by your authority (e.g. `kommunA.crt`). If your certificate does **not** include a private key, you may need to also provide a `.key` file.

If your certificate is provided as a `.p12` (PKCS#12) bundle:
```sh
openssl pkcs12 -in kommunA.p12 -clcerts -nodes -out kommunA.crt
```

Then use with `curl`:
```sh
curl --cert kommunA.crt --cacert ExpiTrust-EID-CA-v4.pem -T testfil.xml "https://shs.test.skatteverket.se/..."
```

---

## Example Curl Command

```sh
curl/curl.exe ^
  --cert certs/kommunA.crt ^
  --cacert certs/ExpiTrust-EID-CA-v4.pem ^
  -T testfil.xml ^
  "https://shs.test.skatteverket.se/et/et_web/auto/<uuid>/"
```

---

## Output Files

The included `upload_testfile.bat` script also saves:
- `trace.txt` (debug trace of the curl request)
- `response.xml` (response body)

---

## Folder Structure

```
/project-folder
├── curl/
│   └── curl.exe
├── certs/
│   ├── kommunA.crt
│   └── ExpiTrust-EID-CA-v4.pem
├── testfile.xml
├── upload_testfile.bat
└── README.md
```

---