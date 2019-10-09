library(shiny)

shinyUI(fluidPage(
    titlePanel("Form to ChIP-seq data Analysis Parameter File"),
    div(
        id = "form",
        uiOutput("HelpBox"),
        HTML("<strong>File Name Format: <span style='color:#6ABF4A'>CellType</span>_<span style='color:#FE6B01'>Mark|input</span>_<span style='color:#13BED2'>Donor|Tissue</span>_<span style='color:#CB03F3'>rep</span>_pe|se[1,2]_[whatever: ID,etc].fastq</strong> <br/> <br/>"),
        textInput("mark_name", HTML("<span style='color:#FE6B01'>Histone Mark or Protein?</span>"), ""),
        selectInput("mark_type", "Signal Type?", c("Broad","Narrow"), selected = F),
        selectInput("genome", "Genome Version to use?", c("GRCh37"), selected = F),
        selectInput("release", "Genome Version Release to use?", c("55"), selected = F),
        textInput("cell_types",HTML("<span style='color:#6ABF4A'>Cell Types?</span>"),""),
        uiOutput("cell_types_ui"),
        div(style="display:inline-block",actionButton("action", label = "Help")),
        downloadButton('downloadData', 'Download')
    )
))
