{
  extraConfigLua = ''
    -- Treat '-' as part of a word, so kebab-case names are one motion.
    vim.opt.iskeyword:append("-")
    -- Let h/l and the arrow keys wrap onto the previous/next line.
    vim.opt.whichwrap:append("<,>,[,],h,l")
  '';
}
