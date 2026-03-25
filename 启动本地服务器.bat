@echo off
cd /d "d:\hgp\胡高鹏创业思路\重庆元膳健康科技有限责任公司文件"
echo Starting local server...
echo Please visit: http://localhost:8000
echo Press Ctrl+C to stop the server
python -m http.server 8000
pause
