# THƯ MỤC PROJECT CỦA BẠN
$workDir = "D:\UET 5th semester\Projects of application development\mongodb_sharding"

# ĐƯỜNG DẪN TỚI BIN CỦA MONGODB
$mongoBin = "C:\Program Files\MongoDB\Server\8.0\bin"

$mongod = Join-Path $mongoBin "mongod.exe"
$mongos = Join-Path $mongoBin "mongos.exe"

# === CONFIG SERVERS ===
Start-Process -FilePath $mongod -WorkingDirectory $workDir -ArgumentList "--configsvr --replSet configReplSet --port 27040 --dbpath .\config1"
Start-Process -FilePath $mongod -WorkingDirectory $workDir -ArgumentList "--configsvr --replSet configReplSet --port 27041 --dbpath .\config2"
Start-Process -FilePath $mongod -WorkingDirectory $workDir -ArgumentList "--configsvr --replSet configReplSet --port 27042 --dbpath .\config3"

# === SHARD 1 ===
Start-Process -FilePath $mongod -WorkingDirectory $workDir -ArgumentList "--shardsvr --replSet shard1 --port 27050 --dbpath .\shard1-1"
Start-Process -FilePath $mongod -WorkingDirectory $workDir -ArgumentList "--shardsvr --replSet shard1 --port 27051 --dbpath .\shard1-2"

# === SHARD 2 ===
Start-Process -FilePath $mongod -WorkingDirectory $workDir -ArgumentList "--shardsvr --replSet shard2 --port 27060 --dbpath .\shard2-1"
Start-Process -FilePath $mongod -WorkingDirectory $workDir -ArgumentList "--shardsvr --replSet shard2 --port 27061 --dbpath .\shard2-2"

# === QUERY ROUTER ===
Start-Process -FilePath $mongos -WorkingDirectory $workDir -ArgumentList "--configdb configReplSet/localhost:27040,localhost:27041,localhost:27042 --port 27070"

Write-Host "✅ MongoDB cluster processes started (nếu bên trên không báo lỗi)."
Write-Host "👉 Kết nối router: mongosh --port 27070"
