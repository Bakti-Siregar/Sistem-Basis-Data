library(shiny)

# Definisikan suatu vector untuk menyimpan informasi yang ingin disimpan/ditampilkan
variabel <- c("nama","usia","kelamin", "pengalaman_shiny", "berapa_tahun")

# Buatlah UI-nya untuk mengumpulkan beberapa informasi dari pengguna web atau apps.
shinyApp(
    ui = fluidPage(
        DT::dataTableOutput("respon", width = 300), tags$hr(),
        textInput("nama", "Nama", ""),
        numericInput("usia", "Usia", 17, min=1, max=120),
        selectInput("kelamin", "Jenis Kelamin", list("Pria", "Wanita")),
        checkboxInput("pengalaman_shiny", "Saya sudah pernah menggunakan Shiny", FALSE),
        sliderInput("berapa_tahun", "Jumlah tahun menggunakan R", 0, 15, 2, ticks = FALSE),
        actionButton("submit", "Submit")
    ),
    
# Buatlah Server-nya (Beck-end), bagian ini berfungsi untuk menyimpan respons
    server = function(input, output, session) {
        
# Setiap kali formulir diisikan, data akan disimpan pada bagian ini
        formData <- reactive({
            data <- sapply(variabel, function(x) input[[x]])
            data
        })
        
# Ketika tombol Submit diklik, simpan data formulir 
        observeEvent(input$submit, {
            saveData(formData())
        })
        
# Tampilkan semua respon sebelumnya
# (Perbarui respon pada saat Submit diklik)
        output$respon <- DT::renderDataTable({
            input$submit
            loadData()
        })     
    }
)
