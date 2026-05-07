const bcrypt = require('bcryptjs');
const saltRounds = 10;

const hash = (password) => bcrypt.hashSync(password, saltRounds);
const compare = (password, hash) => bcrypt.compareSync(password, hash);

module.exports = { hash, compare };