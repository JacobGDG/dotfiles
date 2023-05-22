-- we use https://github.com/ctran/annotate_models to annotate our models
-- this is a pain to scroll past
-- this function jumps to the first line of the model that is not a comment

function SkipTopCommentsRuby()
  -- Check if the current buffer is a Ruby file
  if vim.bo.filetype == 'ruby' then

    -- Loop through each line in the buffer
    for i = 1, vim.fn.line('$') do

      -- Get the current line
      local line = vim.fn.getline(i)

      -- Check if the line is a comment
      if line:match('^%s*#') then
        -- If it is a comment, continue to the next line
        goto continue
      else
        -- If it is not a comment, set the mark at this line
        vim.fn.setpos('.', {0, i, 0, 0})
        break
      end

      ::continue::
    end
  end
end
