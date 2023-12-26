<script language="C#" runat="server">
    public void Page_Load(Object sender, EventArgs ea)
    {
        string msg;

        msg = ReadDB();
        Response.Write(msg);
    }

    string ReadDB()
    {
string selectvindo = this.Request.Params["mensagemenviadaC"] ;
       // string select = "SELECT * FROM vendas";
string select = selectvindo; 
        string caminhoArquivoTXT = Server.MapPath("/data/selecionado.txt");

        System.Data.OleDb.OleDbConnection oConn = new System.Data.OleDb.OleDbConnection();
        oConn.ConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("/data/marketing.mdb");

        try
        {
            oConn.Open();

            // Cria um DataSet e preenche com os dados do banco
             System.Data.DataSet ds = new System.Data.DataSet();
            System.Data.OleDb.OleDbDataAdapter datadapt = new System.Data.OleDb.OleDbDataAdapter(select, oConn);
            datadapt.Fill(ds, "jog");

            // Cria um StringBuilder para construir o conteúdo do arquivo TXT
            System.Text.StringBuilder txtContent = new System.Text.StringBuilder();

            foreach (System.Data.DataTable table in ds.Tables)
            {
                // Adiciona os cabeçalhos das colunas ao conteúdo do arquivo TXT
                txtContent.AppendLine(string.Join(",", table.Columns.Cast<System.Data.DataColumn>().Select(col => col.ColumnName)));

                // Adiciona os dados das linhas ao conteúdo do arquivo TXT
               foreach (System.Data.DataRow row in table.Rows)
                {
                    var values = row.ItemArray.Select(val => val.ToString());
                    txtContent.AppendLine(string.Join(",", values));
                }
            }

             //Escreve o conteúdo no arquivo TXT
            System.IO.File.WriteAllText(caminhoArquivoTXT, txtContent.ToString());

            //return "Arquivo TXT foi gravado com sucesso!";
  return txtContent.ToString() + "$";  

        }
        catch (Exception ex)
        {
            //return "Erro ao acessar o banco de dados: " + ex.Message +" Tente outro tipo de request$";
return "Sinto muito. Nao consegui resolver seu request. Tente outra forma de pedir mais detalhada$";
        }
        finally
        {
            oConn.Close();
        }
    }
</script>
