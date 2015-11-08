

library(stringr)


#' modifies intermediate md file from Rmd rendering and puts in _posts
#' 
#' more more more
#' @param file  path to md file that needs converting
#' @param layout the name of the layout wanted in the yaml header
#' @param title the title of the post.  If NULL then we get it from the md file.
#' @param outdir the directory where the final result should be saved
#' @param imgdir_regex_pattern string giving a regular expression that will pick out the
#' links to the images (plots).
#' @param imgdir_regex_replace replacement string for the imgdir_regex_pattern
Rmd2md <- function(file,
                        layout = "minimal_post",
                        title = NULL,
                        move = TRUE, 
                        outdir = "_posts",
                        imgdir_in = "figure/",
                        imgdir_out = "assets/"
                        ,encoding = "latin1"
                        #,encoding = "unknown"
) {
  
  #x <- readLines(file)
  x <- readLines(file, encoding=encoding)
  if(is.null(title)) {
    title <- gsub(x=x[2], pattern="title: ", replacement="")
  }
  codeout <- tolower(str_replace_all(title, " ", "-"))
  fileout <- paste(Sys.Date(),"-",codeout, ".md", sep="")
  
  # put the md header on it, overwriting the title block that render() stuck on it
  x <- x[-1:-4]
  x[1] <- paste("---\nlayout: ", layout, "\ntitle: ", title, "\n---\n", collapse = "", sep = "")
  
  
  # put the site.url up front on the images
  x2 <- str_replace_all(x, imgdir_in,
                        paste("{{ site.url }}/",
                              imgdir_out,codeout,"-",sep=""))
  
  # find the lines where images are put in:
  imgs <- str_detect(x2, "^<img src")
  
  # on each of those, remove the width and heigh specs, as they just screw things
  # up and change the aspect ratio obtained by knitting with Rmd
  x2[imgs] <- str_replace_all(x2[imgs], "(width|height)=\"[a-z0-9]*\"", "")
  
  # write the result into the output dir
  Encoding(x2) <- encoding
  cat(x2, sep="\n", file = file.path(outdir, fileout))
  
  # if required, move/rename the images
  if(move){
    ff <- dir(path=imgdir_in)
    for (fileimg in ff) {
      f1 <- paste(imgdir_in,fileimg,sep="")
      f2 <- paste(imgdir_out,codeout,"-",fileimg,sep="")
      file.rename(f1,f2)
    }
  }
}
