const app = require("./src/app");

const PORT = 5055

const server = app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
})

process.on("SIGINT", () => {
  server.close( () => console.log("Exit server") )
})