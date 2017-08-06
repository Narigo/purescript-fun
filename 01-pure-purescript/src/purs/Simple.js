// module Simple

exports.concatString = function (a) {
  return function (b) {
    return a + b;
  };
};
