$xslt = New-Object System.Xml.Xsl.XslCompiledTransform;
$template = Resolve-Path "n3.xslt"
$xslt.Load($template);

function doProcess($file)
{
	$result = [io.path]::GetDirectoryName($file) + "\" + [io.path]::GetFileNameWithoutExtension($file) + "-junit.xml" 
	echo "Processing $file to $result"
	[xml]$xml = Get-Content $file
	$n = Select-Xml "//testsuites" $xml 
	if ($n.count -gt 0) {
		echo "junit"
		copy-item $file $result
	} else {
		echo "Transforming"
		$xslt.Transform($file, $result)
	}
	
}

gci -r . -filter "test*.xml" -exclude "*-junit.xml" | foreach { doProcess($_.FullName) }
